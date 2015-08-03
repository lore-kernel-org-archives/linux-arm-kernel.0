From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Aug 2015 11:16:24 +0200
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
 <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
Message-ID: <20150803091624.GZ2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 09:35:51AM +1000, Julian Calaby wrote:
> Hi Timo,
> 
> On Mon, Aug 3, 2015 at 5:23 AM, Timo Sigurdsson
> <public_timo.s@silentcreek.de> wrote:
> > sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20 boards
> > (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
> > voltage for the lowest operating point to 1.0V so all boards can actually use
> > it.
> 
> Surely it wouldn't be added here if some could supply 0.9v.
> 
> Is the code that uses this smart enough to sensibly switch between two
> operating points with the same frequency and different voltages? If
> so, maybe just add a 144MHz @ 1.0v operating point?

And how would it choose between the two exactly ? Switch to the 144MHz
@ 0.9V and see if it works ? If it doesn't you might have screwed your
system already, and might not be able to recover from it at all.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/08e0c339/attachment.sig>
