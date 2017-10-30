From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Mon, 30 Oct 2017 11:32:14 +0000
Subject: [PATCH v10 0/9] LPC: legacy ISA I/O support
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00A6F5C@AcuExch.aculab.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00A6F5C@AcuExch.aculab.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CAE73B@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David

[...]

> FWIW my thoughts on this are WTF!
> 
> Looks to me horribly over complicated and over generalised.
> 
> Surely is it could be done the same way that x86 does IO cycles?

No

> So you encode the information into the 'address' the driver passes
> to ioread16() (etc) to allow it to do either a normal bus cycle or
> the indirect cycle onto the external bus.

In order to do that you need to have a special PCI bridge that is able
to detect the special IO addresses and initiate such special IO cycles
on the external bus. This is not supported by our HW (and this why
we need the LPC accessors)

Gab

> 
> So you have one kernel option that makes these real functions.
> 
> 	David
