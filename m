From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 13 Jun 2012 20:08:47 -0400
Subject: Pogoplug E02 ARM (Kirkwood 88F6281 SoC) target vs 3.5 kernel
In-Reply-To: <CAAeQ1eZbER5k7fw2L0UWpKqiXJLCg2WwUPrRzf40rmv7EKcZ-w@mail.gmail.com>
References: <CAAeQ1eZbER5k7fw2L0UWpKqiXJLCg2WwUPrRzf40rmv7EKcZ-w@mail.gmail.com>
Message-ID: <20120614000847.GJ14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:40:06AM +0200, Jacco Onderdijk wrote:
> I noticed when going from 3.4.2 to 3.5 kernel that the kernel is not
> booting properly. I read in a Google plus post
> 
> <https://plus.google.com/100126049429601461708/posts/Yx63UM6Ubix>
> 
> that board files can be ported to DTS. I am an owner of several
> pogoplug e02 targets (Kirkwood 88F6281 SoC) and i want to help porting
> this target to the 3.5 kernel.
> 
> Here <http://forum.doozan.com/read.php?2,8153,8337#msg-8337> is a log
> of a 3.4.2 kernel booting the Pogoplug E02.
> 
> How can i help, for example with testing or something else?

Awesome, I'm glad you're interested in helping out.  First, always CC:
the linux-arm-kernel mailinglist (I've added it in this reply) so that
everyone can be kept up to date.

Second, take a look at how the first kirkwood conversion happened (the
dreamplug) in git commit 3d468b6.  Basically, the first thing to do, is
to use the devicetree to tell the kernel what board it is booting on.
This replaces the mach_type.  After you have that working, start using
the devicetree to configure the various devices.

If you have any detailed questions, feel free to ask.

hth,

Jason.
