From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 12 Mar 2015 10:35:50 +0100
Subject: Bug in i2c-core?
In-Reply-To: <6018658.iFTJCkgHeH@avalon>
References: <54F0507F.6030804@armadeus.com> <20150304082237.GA2955@katana>
 <20150308082617.GA1904@katana> <6018658.iFTJCkgHeH@avalon>
Message-ID: <20150312093550.GB1000@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > Adding Rob to CC as he wrote of_irq_get and put it into
> > > platform_get_irq. Rob, we use of_irq_get() in the I2C core and the
> > > question is now if we need to dispose the mapping and if so what would
> > > be a good place for it so managed devices will not have their mappings
> > > removed before the managed irq is removed.
> > 
> > Ping. Just so you know: Without further information, I will revert the
> > patch in question around rc4/rc5. I'd still like to know if the
> > non-disposing of the mapping in platform_get_irq() is intentional.
> 
> I'll defer that to Rob. I'm fine with the revert at the moment.

Added the revert to for-current now with your and Dmitry's ack.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150312/dc8cd6eb/attachment.sig>
