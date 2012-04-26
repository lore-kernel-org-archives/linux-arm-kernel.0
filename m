From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 26 Apr 2012 23:04:02 +0530
Subject: [PATCH] arm: davinci: pdctl next bit position incorrect
In-Reply-To: <4F917C12.8080306@mvista.com>
References: <1334745664-19275-1-git-send-email-m-karicheri2@ti.com>
 <4F8F22D1.8080309@ti.com> <4F8FECD6.6050105@mvista.com>
 <4F9042CA.7050305@ti.com> <4F917C12.8080306@mvista.com>
Message-ID: <4F99870A.6080201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 4/20/2012 8:39 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/19/2012 08:52 PM, Sekhar Nori wrote:
> 
>>>>> The PDCTL NEXT bit is incorrectly set to bit 1 instead of bit 0. This
>>>>> patch fixes this issue
> 
>>>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
> 
>>>> Applying this for v3.5.
> 
>>>     But why not to 3.4? It concerns turning on DSP domain on DM644x.
> 
>> Yes, but I think as you noted sometime before, no one is really
>> depending on kernel to turn on DSP domain on DM644x.
> 
>    Looks like you're right (though I don't remember noting it :-).
> 
>> Its probably being
>> done from U-Boot or ROM code. This is not a v3.4 regression either.
> 
>    U-Boot does it only when DSPLINK support is not desired.

Okay. Since DSPLink existed long before this code to turn on domain was
introduced by Murali, it must be having its own private code to do this.
So, looks like this should not really be a regression for anyone.

Thanks,
Sekhar
