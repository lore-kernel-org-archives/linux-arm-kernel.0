From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 31 Mar 2016 06:30:11 -0400
Subject: Boot failure on i.MX6 boards due to commit 5e3ca2b349b1
 ("regulator: Try to resolve regulators supplies on registration")
In-Reply-To: <20160331122149.56281b0d@ipc1.ka-ro>
References: <20160331122149.56281b0d@ipc1.ka-ro>
Message-ID: <CABxcv=nrxhyToLfjQS65LnOAxRn1NUL+DAKM-O3fpe6Ma_dpaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Jon Hunter to cc list]

Hello Lothar,

On Thu, Mar 31, 2016 at 6:21 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> booting a TX6 module (i.MX6Q or i.MX6DL) fails with current linux-next.
> Bisecting revealed the culprit to be commit:
> 5e3ca2b349b1 (""regulator: Try to resolve regulators supplies on registration)
>
> Reverting this commit on top of next-20163031 makes the board functional again.
>

Yes, the patch introduced a deadlock on platforms that do legacy
(non-DT) regulators lookup.

Could you please try Jon's patch?

https://lkml.org/lkml/2016/3/30/475

Best regards,
Javier
