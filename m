From: andreas@kemnade.info (Andreas Kemnade)
Date: Thu, 8 Mar 2018 07:16:44 +0100
Subject: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
In-Reply-To: <20180118064736.GH3286@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost> <20180109184347.28ba0a6e@aktux>
 <20180112144647.GA5992@localhost>
 <20180112194022.7da1e726@kemnade.info>
 <20180118064736.GH3286@localhost>
Message-ID: <20180308071459.310d0ba2@aktux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 18 Jan 2018 17:47:36 +1100
Johan Hovold <johan@kernel.org> wrote:

[...]
> > 
> > So to avoid having hardware information spread all over the table at least
> > these information would need to be in devicetree. But that also all feels
> > like a hack and hard to maintain.  
> 
> Having the device described in the device tree is certainly desirable,
> not least for chip identification. And with a GPS framework in the
> kernel with a well-defined interface, implementing power management
> would be straight forward.
> 
Hmm, devicetree without in-kernel drivers, do we have anything like that
somewhere? I thought that was a big no-go. But maybe I am wrong.

> I'm just not convinced that the proposed tty interface is the right
> interface for this. User space would still rely on gpsd for the GPS
> protocols, and would also ultimately be managing power by killing gpsd
> or whatever daemon that would otherwise be holding the port open.
> 
> Something like the generic power sequences that has been discussed
> elsewhere might be a better fit for this if all you want to do is power
> on and off on port open and close (and on suspend/resume). There really
> isn't anything GPS-specific in the current proposal (besides the
> suggested tty-device name).

So a bit like that mmc-powerseq stuff we already have?
> 
> But sure, that wouldn't be sufficient to deal with the
> unknown-power-state problem with the device in question.
> 
Maybe there could be a kind of active flag set by the tty if
there is traffic, so that active flag could be used in these
power sequence stuff? But then again the tty layer has to be extended
which would probably also cause a lot of ruffled feathers.

Regards,
Andreas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/d10e2282/attachment.sig>
