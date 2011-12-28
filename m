From: linux@solonet.org.ua (Denis Kuzmenko)
Date: Wed, 28 Dec 2011 23:02:22 +0200
Subject: [PATCHv2 resend] Fix compilation error when
 CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected.
In-Reply-To: <01e501ccc536$a6e58fb0$f4b0af10$%kim@samsung.com>
References: <4EE7BE5F.8020108@solonet.org.ua>
 <01e501ccc536$a6e58fb0$f4b0af10$%kim@samsung.com>
Message-ID: <4EFB83DE.7080404@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Your patch applies (note that it looks like your email-client have
wrapped long lines thus broke the path) and works OK. Looks good to me.
See some additional comments below.

On 12/28/2011 09:59 AM, Kukjin Kim wrote:
> Denis Kuzmenko wrote:
(snip)
>> +	depends on CPU_FREQ_S3C24XX && (S3C2410_IOTIMING ||
>> S3C2412_IOTIMING)
> 
> As you know, CONFIG_CPU_FREQ_S3C24XX_IODEBUG is for enabling of
> s3c_freq_iodbg() and there is no problem when CONFIG_S3C241{0,2}_IOTIMING is
> not selected, even though s3c_freq_iodbg() is used only at
> s3c2410-iotiming.c now. So this is not necessary to fix the problem you
> said.

I'm OK with this approach, however I don't see any future use of
s3c_freq_iodbg() without s3c2410-iotiming.c. But it's not anyway
critical so please pick any variant which you like.

(snip)
> Well, do we really need to have '#ifdef CONFIG_CPU_FREQ_S3C24XX_DEBUGFS'
> here?
> I think, just having dependency with CONFIG_S3C241{1,2}_IOTIMING can avoid
> the build error.

Yes, CONFIG_S3C241{1,2}_IOTIMING dependency is just enough.

(snip)
>> -extern int s3c2412_iotiming_get(struct s3c_cpufreq_config *cfg,
>> -				struct s3c_iotimings *timings);
>> -
> 
> Yes, why is this duplicated :(

Don't have an idea. I'm new to this platform and to Linux at all so I
don't know how it appeared.
Just another harmless mistype I think.

(snip)
> So how about at below?
> If you're ok, will send before v3.2.

So, as already said, I have no objections.
And thank you for review.

-- 
Best regards, Denis Kuzmenko.
