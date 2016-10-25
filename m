From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 25 Oct 2016 13:57:51 -0500
Subject: [PATCH 3/3] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <5e0adad1-8ef2-029f-cfcd-4a07c962fda2@opensource.altera.com>
References: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
 <1476908324-12313-3-git-send-email-dinguyen@opensource.altera.com>
 <20161020071913.rlka3or4c7fzjpyv@pengutronix.de>
 <c62baad6-2528-a9df-6b09-3dba66785102@opensource.altera.com>
 <5e0adad1-8ef2-029f-cfcd-4a07c962fda2@opensource.altera.com>
Message-ID: <580FAB2F.1050602@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2016 10:38 AM, Graham Moore wrote:
> On 10/20/2016 09:12 AM, Dinh Nguyen wrote:
>>
>>
>> On 10/20/2016 02:19 AM, Steffen Trumtrar wrote:
>>
>>>> +        cdns,tslch-ns = <4>;
>>>> +
>>>> +        partition at qspi-boot {
>>>> +            /* 8MB for raw data. */
>>>> +            label = "Flash 0 Raw Data";
>>>> +            reg = <0x0 0x800000>;
>>>> +        };
>>>> +
>>>> +        partition at qspi-rootfs {
>>>> +            /* 120MB for jffs2 data. */
>>>> +            label = "Flash 0 jffs2 Filesystem";
>>>> +            reg = <0x800000 0x7800000>;
>>>> +        };
>>>> +    };
>>>> +};
>>>> +
>>>
>>> What is the current preferred way of handling the partitions?
>>> This doesn't fit my Sockit configuration for example. So I would always
>>> have to patch the devicetree.
>>
>> I'm not 100% sure on this. Graham, do you have any insight?
>>>
> 
> Well, strictly speaking, these partitions are only for the socdk, the
> Altera dev kit.  Our sample designs and file systems expect this layout.
> 
> Therefore, these partitions are not required for any other dev kits, and
> can probably be left out.
> 
> Or, Steffen, if you have a standard layout you'd like to see, then put
> that in there.
> 
> I think some people will have to patch the layout regardless.
> 

Ok, I'll remove the partitions from the none Altera boards.

Dinh
