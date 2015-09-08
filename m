From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Sep 2015 13:23:22 +0100
Subject: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
In-Reply-To: <55EEAC01.3080409@atmel.com>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk> <55EEAC01.3080409@atmel.com>
Message-ID: <20150908122322.GB9751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 05:36:01PM +0800, Wu, Songjun wrote:
> On 9/8/2015 00:23, Mark Brown wrote:

> >OK, so that's not actually what the code was doing - it had separate
> >enums for bass, mid and treble.  If you make this a single enum with all
> >the above options in it that seems like the best way of handling things.

> A single enum seems not very friendly to user, there are tree EQs, bass,
> medium and treble.
> So I create tree enum controls to control three EQs.
> The 'get' function is replaced by 'classd_get_eq_enum', if user operates one
> of the tree EQ controls, the other two EQs will show 0 dB.

If you want to have three controls you need to write code so that the
user can only change one of them from 0dB at once, returning an error
otherwise.  That was why it looked like they were three separate
controls.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150908/3fafc3c9/attachment-0001.sig>
