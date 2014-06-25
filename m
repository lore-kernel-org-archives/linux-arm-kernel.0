From: joel.schopp@amd.com (Joel Schopp)
Date: Wed, 25 Jun 2014 15:14:50 -0500
Subject: [RFC PATCH 3/9] irqchip: GIC: Convert to EOImode == 1
In-Reply-To: <CAAhSdy11HQtiOD6XLqQcZ+zf_Z9Mx0nPrJ0ECNNuRkZt=CfdpA@mail.gmail.com>
References: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
 <1403688530-23273-4-git-send-email-marc.zyngier@arm.com>
 <CAAhSdy11HQtiOD6XLqQcZ+zf_Z9Mx0nPrJ0ECNNuRkZt=CfdpA@mail.gmail.com>
Message-ID: <53AB2DBA.8040407@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> +               if (resource_size(&cpu_res) >= SZ_8K)
>> +                       supports_deactivate = true;
>> +               else
>> +                       pr_warn("GIC: CPU interface size is %x, DT is probably wrong\n", (int)resource_size(&cpu_res));
> This will not work on APM X-Gene because, for
> X-Gene first CPU page is at 0x78020000 and
> second CPU page is at 0x78030000.
>
> Ian had send-out a patch long time back to extend
> GIC dt-bindings for addressing this issue.
> (http://www.spinics.net/lists/arm-kernel/msg283767.html)

We have a similar issue with an AMD SOC.  You can add 0xf000 (60K) page 
offset to it to cleverly work around the issue but it seems quite likely 
that the page offset has to be communicated to userspace and handled 
there at no small effort.

Anybody want to revive Ian's split patches?  They do seem convoluted but 
seem like they might work as an approach.

-Joel
