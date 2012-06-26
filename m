From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 26 Jun 2012 10:53:16 +0530
Subject: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
In-Reply-To: <4FE9467A.2050906@ti.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
 <20120614154820.GG17140@kroah.com>
 <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com>
 <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com>
 <20120625182830.GA23850@kroah.com>
 <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com>
 <4FE9467A.2050906@ti.com>
Message-ID: <CAMQu2gzOszT54ZU0Z3-9k=mMM7yTCH_MCZV=gRKwGoGRj0zjaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 10:49 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Tuesday 26 June 2012 10:39 AM, Shilimkar, Santosh wrote:
>>>>
>>>> +#if defined(CONFIG_OF)
>>>> > ?> ?+static const struct of_device_id emif_of_match[] = {
>>>> > ?> ?+ ? ? ? ? ? ? { .compatible = "ti,emif-4d" },
>>>> > ?> ?+ ? ? ? ? ? ? { .compatible = "ti,emif-4d5" },
>>>> > ?> ?+ ? ? ? ? ? ? {},
>>>> > ?> ?+};
>>>> > ?> ?+MODULE_DEVICE_TABLE(of, emif_of_match);
>>>> > ?> ?+#endif
>>>> > ?> ?+
>>>> > ?> ? ?static struct platform_driver emif_driver = {
>>>> > ?> ? ? ? ? .remove ? ? ? ? = __exit_p(emif_remove),
>>>> > ?> ? ? ? ? .shutdown ? ? ? = emif_shutdown,
>>>> > ?> ? ? ? ? .driver = {
>>>> > ?> ? ? ? ? ? ? ? ? .name = "emif",
>>>> > ?> ?+#if defined(CONFIG_OF)
>>>> > ?> ?+ ? ? ? ? ? ? .of_match_table = of_match_ptr(emif_of_match),
>>>> > ?> ?+#endif
>>>
>>> >
>>> > ?Are these two still #if defined needed?
>>> >
>>> > ?Also, what about the IS_DEFINED macro?
>>> >
>>
>> Yes. To avoid the build break in !DT build.
>>
>
> No, infact of_match_ptr is there just so you can avoid a
> #ifdef around and not break !CONFIG_OF.

Need to recheck but the build was throwing error becasue of "emif_of_match"
mostly.

Regards
Santosh
