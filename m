From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 28 Sep 2011 08:55:56 +0530
Subject: [linux-pm Query] Power Management Device Suspend/ Resume
In-Reply-To: <CAO1yOm2pbApTwa0gj3Q9RsC1mxNGGirxm6FzaDC7zbgjHdkKDw@mail.gmail.com>
References: <CAO1yOm2pbApTwa0gj3Q9RsC1mxNGGirxm6FzaDC7zbgjHdkKDw@mail.gmail.com>
Message-ID: <4E8293C4.5090009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Can somebody please help us understand suspend/resume.
It would be a great help, even if you can point us to some earlier fruitful
discussion.

--
viresh

On 9/22/2011 4:19 PM, Deepak Sikri wrote:
> Hi,
>  
> We are in the process of adding Suspend/ Resume call backs for the devices on SPEAr platform.
> The platform makes use of various power domains which could be turned off (during suspend, implying
> the devices in those power domains lose their context).
>  
> *There are certain queries*.
>  
> *Query- 1*. Suppose my platform has a ADC driver under char framework, which internally uses the
> DMA driver (channels). Now, ADC driver can be used by other kernel drivers or directly from user application.
>  
> *1. a.* What are the expectations from the suspend and resume routines of both the devices, DMA & ADC ?
>  
> */-- Given that few of the options are/*
> */1.a.1. On suspend,/*
> In ADC suspend function: ADC releases all the DMA channels, latches its registers; and
> DMA suspend function: DMA does nothing except for lataching of registers if required.
>  
> */1.a.2. On suspend, /*
> ADC suspend function: ADC just latches its registers and stops R/W through DMA, no DMA channel release;
> DMA suspend function: DMA halts its operating channels, and latches its registers if required.
>  
> */1.a.3 Some other alternative/*
> *//* 
>  
> *1.b* Will the suspend resume for the dependent drivers follow sequencing, i.e. Suspend of ADC followed by
> Suspend of DMA? (Assume both of these devices are hooked on to Platform bus, given that ADC uses DMA)
>  
> *Query-2*
>  
> 2.1 The user space threads freeze first followed by kernel space.  In case the user space process issues a a system
> call (lets assume an ioctl system call), how will the user space thread respond in case of suspend to ram?
>  
> 2.2 Will the kernel thread running on behalf of user space process complete the ioctl call OR 
>  freeze upon in the middle of execution?
>  
> *Query-3*
> ** 
> Are there any modalities w.r.t latching and restoring the contents at the driver level ?
> that is: Should this process be handled at drier level or platform specific code can also handle this
>  
>  
> Thanks & Regards
> Deepak
