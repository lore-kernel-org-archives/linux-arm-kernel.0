From: damien.riegel.ext@parrot.com (Damien Riegel)
Date: Thu, 25 Jul 2013 16:42:59 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <CACRpkdb-hVE1Jj69ttrn+zf5cEuMHhxNh2OyhfTtrG+yUiO+jg@mail.gmail.com>
References: <51E667BC.3070804@parrot.com>	<51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
 <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
 <51F12629.7090909@parrot.com>
 <CACRpkdb-hVE1Jj69ttrn+zf5cEuMHhxNh2OyhfTtrG+yUiO+jg@mail.gmail.com>
Message-ID: <51F13973.70806@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Does this recently submitted documentation patch help in explaining
> some of your questions?
> http://marc.info/?l=linux-kernel&m=137442899829271&w=2
This is a very helpful addition to the existing documentation.

My reflection rather was: when gpio is not orthogonal, we could just
check mux_owner to see if pin is available; and when it is, use the
current implementation.

But well, we obviously need to way to tell if gpios are orthogonal or
not, and adding a function to struct pinmux_ops is an elegant solution
to do so since it even allows a pin granularity.

I guess I sent my previous mail a bit too quickly.
