From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 14 Nov 2014 18:34:18 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141114172008.GB12250@earth.universe>
References: <20141104205117.GA17606@amd> <5465A977.4030605@gmail.com>
 <20141114172008.GB12250@earth.universe>
Message-ID: <201411141834.19242@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 18:20:09 Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 14, 2014 at 09:04:23AM +0200, Ivaylo Dimitrov 
wrote:
> > [...]
> > https://gitorious.org/linux-n900/freemangordons-linux-n900/c
> > ommits/30e9a5c498a89cea4c29523f69e436bf0af3c631
> > 
> > commits 89ce13b, b81d80d, ec4d0dc, 91256e2 and 8022a6d -
> > e29f558 (no idea why gitorious shows those mixed with SGX
> > stuff, on my local tree it is contiguous patch series)
> > 
> > didn't test against the current upstream, but I see no
> > reason why those should not apply, build and run.
> 
> The patch looks ok. It does not cleanup the cmt-speech driver
> for mainline usage, but it should work. Before adding this
> driver to the mainline kernel there should be open source
> userspace support anyway.
> 
> Btw. I am aware that this would break existing pulse audio
> stuff, but wouldn't it make sense to export a V4L2 device
> instead of the custom /dev/cmt_speech ABI?
> 

It is not good idea to break existing applications even if they 
are closed... And there are some open source meego/nemo 
pulseaudio modules which using cmt speech (but audio quality is 
worse).

Anyway what is /dev/cmt_speech doing? If it exports gsm voice 
call data, should not it have alsa snd interface?

V4L2 interface is not for video/camera/capture/tv cards?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/895d1e1e/attachment.sig>
