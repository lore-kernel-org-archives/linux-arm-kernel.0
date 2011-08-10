From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Aug 2011 09:06:43 +0530
Subject: [PATCH 4/6] spi/spi-pl022: calculate_effective_freq() must set
	rate <= requested rate
In-Reply-To: <CACRpkdYAkPtOkVuF-UhpFHugvZpw_owmgoxP_opF8KE=cYF95w@mail.gmail.com>
References: <cover.1312887860.git.viresh.kumar@st.com>	<abd4dbaedf226ad29461775bcd969810c87c305d.1312887860.git.viresh.kumar@st.com>
	<CACRpkdYAkPtOkVuF-UhpFHugvZpw_owmgoxP_opF8KE=cYF95w@mail.gmail.com>
Message-ID: <4E41FCCB.7040609@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Probably you missed reply-all by mistake, so adding them again]

On 08/10/2011 01:34 AM, Linus Walleij wrote:
> On Tue, Aug 9, 2011 at 1:05 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> 
>> There were few issues with calculate_effective_freq() routine:
>> - It was returning first rate found >= requested rate. Now, if system have spi's
>>  rate as 83 MHz, with possible prescaled rates as 83, 41.5, 20.75, 13.83 (as we
>>  can prescale with multiples of 2). If user has given rate to be programmed as
>>  22 MHz, then driver programmes it to 41.5 MHz. This looks to be incorrect, as
>>  user might have given the upper limit of the device, and we are programming it
>>  above it.
>> - Driver finds the first satisfying rate and programmes it, but with other
>>  values of scr & cpsdvsr, it is possible to get more closer rate.
> 
> Good that you found this bug!
> 
>> +#define SPI_RATE(rate, cpsdvsr, scr)   (rate / (cpsdvsr * (1 + scr)))
> 
> Can you use a static inline instead of a macro? It is often preferred.
> If you do, this is Acked-by.
> 

Not a problem. Will surely do that.

-- 
viresh
