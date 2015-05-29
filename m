From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 May 2015 23:13:51 +0200
Subject: [PATCH 07/12] i2c: pxa: Reset i2c controller on timeout in
 interrupt and pio mode
In-Reply-To: <1432818224-17070-8-git-send-email-vaibhav.hiremath@linaro.org>
 (Vaibhav Hiremath's message of "Thu, 28 May 2015 18:33:39 +0530")
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-8-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87r3pzxf1s.fsf@belgarion.home>
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
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
I have the same comment as before.
I don't like a reset in the transfer path, especially in normal busy phases for
slow I2C devices. A quirk as before.

Cheers.

--
Robert
