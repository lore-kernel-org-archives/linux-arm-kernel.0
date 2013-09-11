From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 11 Sep 2013 13:36:58 +0530
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <Pine.LNX.4.64.1309101853170.16010@axis700.grange>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
 <Pine.LNX.4.64.1309101656150.16010@axis700.grange>
 <CAKohpomBBKLhNemVUpUHAftGhPJJe+ZB7T_9UYLD7LwpR1nK0g@mail.gmail.com>
 <Pine.LNX.4.64.1309101740120.16010@axis700.grange>
 <CAKohpomK7Y_6aLMA3B+hZrtgYq9U89ihgkbvYWA3BsKN3gJD3g@mail.gmail.com>
 <Pine.LNX.4.64.1309101853170.16010@axis700.grange>
Message-ID: <CAKohpokaHU0V86DPB7nEQ8ndwu_mJ_x_Uz47XPHZeyAW3hcP_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 September 2013 22:37, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On Tue, 10 Sep 2013, Viresh Kumar wrote:
>> Quite straight forward actually..
>
> Apparently, not quite.

I overlooked the situation where we return early from ->target() routines.. :(

Please try attached patches, I will repost them later (once I am able to
convince Rafael that these are really important :) )

--
viresh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-distinguish-drivers-that-do-asynchronous-not.patch
Type: application/octet-stream
Size: 2313 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/89e6231f/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-cpufreq-fix-notification-serialization-issues.patch
Type: application/octet-stream
Size: 4388 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/89e6231f/attachment-0001.obj>
