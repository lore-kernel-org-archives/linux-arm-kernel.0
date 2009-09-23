From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 23 Sep 2009 18:24:01 +0300
Subject: Problem with s3c24xx pwm driver
Message-ID: <200909231824.11671.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm encountering very strange problem with s3c24xx pwm driver. I'm using it 
with pwm-bl driver. When backlight level is 0, pwm-bl calls pwm_config(0, 
period); pwm_disable(), otherwise it calls pwm_config(duty, period); 
pwm_enable().

Problem is that after pwm was disabled, it can't be enabled with 
pwm_config(duty, period); pwm_enable() for some (but not all) _valid_ 
duty/period combinations.

pwm-bl works fine if pwm_disable() call is commented out.

Does anybody know how to solve this problem? Any suggestions?

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090923/436b5290/attachment.sig>
