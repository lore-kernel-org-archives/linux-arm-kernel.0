From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Jul 2015 17:27:25 +0200
Subject: [PATCH-V2 04/12] i2c: pxa: Reset i2c controller on timeout in
 interrupt and pio mode
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434383399-2370-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87fv55clcy.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

> In case of timeout during msg xfer assert reset to
> i2c controller for both interrupt and PIO mode of operation.
>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> [vaibhav.hiremath at linaro.org: Split & merge patches into logical changes
> and update the Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

I already said it previously, I'm against an unconditional reset in a timeout
path. Make it a quirk or whatever, but in the current status, I'm against.

The previous behavior looks correct to me : upon timeout, retry, no need to
reset.

--
Robert
