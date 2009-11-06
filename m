From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 6 Nov 2009 18:39:42 +0100
Subject: [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
In-Reply-To: <87y6mjlh1m.fsf@free.fr>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<1257266734-28673-2-git-send-email-ospite@studenti.unina.it>
	<f17812d70911032238i3ae6fa19g24720662b9079f24@mail.gmail.com>
	<Pine.LNX.4.64.0911040907400.4837@axis700.grange>
	<20091104123536.9b95d161.ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911061720570.4389@axis700.grange>
	<87y6mjlh1m.fsf@free.fr>
Message-ID: <20091106183942.2411ef35.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 Nov 2009 18:05:57 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> 
> > Good that you mentioned this. In fact, I think, that .init should go. So 
> > far it is used in pcm990-baseboard.c to initialise pins. You're doing 
> > essentially the same - requesting and configuring GPIOs. And it has been 
> > agreed, that there is so far no real case, where a static 
> > GPIO-configuration wouldn't work. So, I would suggest you remove .init, 
> > configure GPIOs statically. And then submit a patch to remove .init 
> > completely from struct pxacamera_platform_data. Robert, do you agree?
> 
> Yes, fully agree, I think too that GPIO should be static.
>

Well, the other drivers I am using (pxamci, ezx-pcap, gpio-keys,
to mention some) request and configure GPIOs during their own
init/probe, they don't require the *board* init code to configure them.

But if you really like the static way I'll bend to your will.

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091106/f278ad15/attachment-0001.sig>
