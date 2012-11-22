From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 22 Nov 2012 16:44:43 +0200
Subject: OMAP4430 produces boot warnings
In-Reply-To: <1353594842.786.45.camel@sokoban>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>
 <50AE1DC0.3030002@ti.com> <50AE2BB6.8080406@ti.com>
 <1353594842.786.45.camel@sokoban>
Message-ID: <50AE3A5B.5040603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-22 16:34, Tero Kristo wrote:

> I guess you checked that DSS pwrdm is switching between RET and ON in
> your setup?

Yes:

# cat /debug/pm_debug/count |grep dss
[   35.356567] pwrdm state mismatch(l3init_pwrdm) 3 != 1
[   35.361938] pwrdm state mismatch(cam_pwrdm) 3 != 0
[   35.366973] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
[   35.372253] pwrdm state mismatch(tesla_pwrdm) 3 != 1
[   35.377532] pwrdm state mismatch(abe_pwrdm) 3 != 1
dss_pwrdm (RET),OFF:1,RET:11,INA:0,ON:11,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
l3_dss_clkdm->dss_pwrdm (0)

then I load and unload the dss modules, and then:

# cat /debug/pm_debug/count |grep dss
[   60.813629] pwrdm state mismatch(l3init_pwrdm) 3 != 1
[   60.819000] pwrdm state mismatch(cam_pwrdm) 3 != 0
[   60.824127] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
[   60.829376] pwrdm state mismatch(tesla_pwrdm) 3 != 1
[   60.834625] pwrdm state mismatch(abe_pwrdm) 3 != 1
dss_pwrdm (ON),OFF:1,RET:21,INA:0,ON:22,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
l3_dss_clkdm->dss_pwrdm (0)

>> Does the pwrdm mistakenly think that in RET state the DSS still keeps
>> the register contents?
> 
> This might be the case, however the pwrdm code should be generic and
> handle all domains properly. What is the tree / branch / commit you are
> using for testing this stuff? I can take a look at this also.

arm-soc/for-next

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/54916d83/attachment.sig>
