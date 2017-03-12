From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Sun, 12 Mar 2017 13:00:36 -0700
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170312194700.GR21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170312194700.GR21222@n2100.armlinux.org.uk>
Message-ID: <3966c32f-62c0-2809-9db3-d0c0b4eadfc8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/12/2017 12:47 PM, Russell King - ARM Linux wrote:
> Another issue.
>
> The "reboot and the /dev/video* devices come up in a completely
> different order" problem seems to exist with this version.
>
> The dot graph I supplied previously had "ipu1_csi0 capture" on
> /dev/video4.  I've just rebooted, and now I find it's on
> /dev/video2 instead.

Yes, that's still an issue I haven't had the chance to get to
yet.

It could be as simple as passing a fixed device node # to
video_register_device(), but something tells me it won't be
that easy. But I'll get to this in next version.

Steve

>
> Here's the extract from the .dot file of the old listing:
>
>         n00000018 [label="ipu1_ic_prpenc capture\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
>         n00000021 [label="ipu1_ic_prpvf capture\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
>         n0000002e [label="ipu2_ic_prpenc capture\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
>         n00000037 [label="ipu2_ic_prpvf capture\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
>         n00000048 [label="ipu1_csi0 capture\n/dev/video4", shape=box, style=filled, fillcolor=yellow]
>         n00000052 [label="ipu1_csi1 capture\n/dev/video5", shape=box, style=filled, fillcolor=yellow]
>         n00000062 [label="ipu2_csi0 capture\n/dev/video6", shape=box, style=filled, fillcolor=yellow]
>         n0000006c [label="ipu2_csi1 capture\n/dev/video7", shape=box, style=filled, fillcolor=yellow]
>
> and here's the same after reboot:
>
>         n00000014 [label="ipu1_csi0 capture\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
>         n0000001e [label="ipu1_csi1 capture\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
>         n00000028 [label="ipu2_csi0 capture\n/dev/video4", shape=box, style=filled, fillcolor=yellow]
>         n00000035 [label="ipu1_ic_prpenc capture\n/dev/video5", shape=box, style=filled, fillcolor=yellow]
>         n0000003e [label="ipu1_ic_prpvf capture\n/dev/video6", shape=box, style=filled, fillcolor=yellow]
>         n0000004c [label="ipu2_csi1 capture\n/dev/video7", shape=box, style=filled, fillcolor=yellow]
>         n00000059 [label="ipu2_ic_prpenc capture\n/dev/video8", shape=box, style=filled, fillcolor=yellow]
>         n00000062 [label="ipu2_ic_prpvf capture\n/dev/video9", shape=box, style=filled, fillcolor=yellow]
>
> (/dev/video0 and /dev/video1 are taken up by CODA, since I updated the
> names of the firmware files, and now CODA initialises... seems the
> back-compat filenames don't work, but that's not a problem with imx6
> capture.)
>
