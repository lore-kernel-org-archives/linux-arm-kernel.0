From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Sep 2015 10:52:45 +0100
Subject: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
In-Reply-To: <55EFA478.1000109@atmel.com>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk> <55EEAC01.3080409@atmel.com>
 <20150908122322.GB9751@sirena.org.uk> <55EFA478.1000109@atmel.com>
Message-ID: <20150909095245.GG9751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 11:16:08AM +0800, Wu, Songjun wrote:
> On 9/8/2015 20:23, Mark Brown wrote:

> >If you want to have three controls you need to write code so that the
> >user can only change one of them from 0dB at once, returning an error
> >otherwise.  That was why it looked like they were three separate
> >controls.

> If user operates two or tree controls at the same time, for my
> understanding, these operations are serial actually in kernel, not parallel,
> and the last operation will be effective. I only write the function
> 'classd_get_eq_enum' to get the enumeration value, if user changes one of
> controls, the other controls will get 0dB. Is my understanding correct?

Yes, that's what's going to end up happening but it's not how controls
are expected to behave - applications will expect changing one control
to leave others unaffected so it's better to return an error rather than
change the other control.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150909/a105d0ce/attachment.sig>
