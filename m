From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 19 Jun 2013 23:26:33 +0200
Subject: [RESEND,PATCHv6 1/1] Add support for GMT G762/G763 PWM fan
 controllers
In-Reply-To: <20130619205321.GA7625@roeck-us.net>
References: <87sj0jhuhn.fsf@natisbad.org> <20130617101948.GY7626@kw.sim.vm.gnt>
 <8761x9svpf.fsf@natisbad.org> <20130619205321.GA7625@roeck-us.net>
Message-ID: <20130619212633.GC7626@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 01:53:21PM -0700, Guenter Roeck wrote:
> On Wed, Jun 19, 2013 at 10:15:56PM +0200, Arnaud Ebalard wrote:
> > Hi Simon,
> > 
> > Simon Guinot <simon.guinot@sequanux.org> writes:
> > 
> > > I have tested this patch on my 2Big Network v2 board.
> > >
> > > Sometimes I get a weird "No such device" error while reading or writing
> > > the hwmon sysfs attributes. For example:
> > >
> > > # cat pwm1
> > > cat: read error: No such device
> > > # cat pwm1
> > > 0
> > 
> This is odd, since ENODEV should not be returned as error code from i2c read
> operations.
> 
> What is the i2c controller ?

The controller is the very same as for the ReadyNAS Duo v2. It is built
in the Marvell Kirkwood SoC and the driver is i2c-mv64xxx.

I will try an another board to see if I reproduce the error.

Regards,

Simon

> 
> Thanks,
> Guenter
> 
> > Weird, I cannot reproduce that at all on my ReadyNAS Duo v2.
> > 
> > > Note, that if the same command is executed again (just after the faulty
> > > one), then it will succeed most of the time. The errors seems to happen
> > > quite randomly and not very often. I'd say one time over ten tries.
> > > I suppose this error is now visible due to the enhanced error path in
> > > g762_update_client. It looks like we learn something by checking the
> > > return value for i2c_smbus_read_byte_data :)
> > >
> > > Except that, all is working as expected. This new version fixes
> > > effectively open-loop driving when the set_cnt register is set to 0xff.
> > >
> > > Also I am planning (hopefully this Wednesday) to test your patch on my
> > > 5Big Network v2 board. This last also embed a g762 controller but with a
> > > three wires fan instead. Then, I should be able to test the closed-loop
> > > mode behaviour.
> > 
> > Thanks for your tests, Simon.
> > 
> > Cheers,
> > 
> > a+ 
> > 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/819c7284/attachment-0001.sig>
