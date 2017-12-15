From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 15 Dec 2017 09:44:19 +0100
Subject: [PATCH v3 01/11] dt-bindings: thermal: Describe Armada AP806 and
 CP110
In-Reply-To: <20171215093203.74b7a59c@xps13> (Miquel RAYNAL's message of "Fri,
 15 Dec 2017 09:32:03 +0100")
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-2-miquel.raynal@free-electrons.com>
 <20171215082759.7t24ka3lpkulcb7r@tarshish>
 <20171215093203.74b7a59c@xps13>
Message-ID: <87po7gmlcs.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On ven., d?c. 15 2017, Miquel RAYNAL <miquel.raynal@free-electrons.com> wrote:

> Hello Baruch,
>
> On Fri, 15 Dec 2017 10:27:59 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
>
>> Hi Miquel
>> 
>> On Thu, Dec 14, 2017 at 11:30:01AM +0100, Miquel Raynal wrote:
>> > +- marvell,thermal-zone-name: The name to identify the thermal zone
>> > +                             within the sysfs, useful when multiple
>> > +                             thermal zones are registered (AP,
>> > CPx...).  
>> 
>> I don't think that would be acceptable. DT is about describing the
>> hardware. sysfs is a Linux implementation detail which is not tied to
>> any specific hardware. If this is accepted, the property should be
>> named 'linux,thermal-zone-name'.
>
> You are right the sysfs mention should not appear in the description.
>
> Otherwise for the naming I'm not sure "linux," is a valid prefix in
> that case.

Actually the choice between linux or marvell make me realize that there
is something wrong. Having a name associated to a device is something
pretty usual with the device tree, however it is as the class device
level, such as clock-names, line-name, or regulator-name. So in my
opinion if we want to support naming from device tree it would be done
for all the thermal device not just for the Marvell one.

However I don't think we need it. For example for the clocks we created
the name dynamically using of the base address of the register to keep
them unique.

Gregory


>
> Miqu?l
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
