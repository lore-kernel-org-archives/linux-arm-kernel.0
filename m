From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Oct 2017 21:09:58 +0200
Subject: [PATCH v3 12/12] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <20171011120036.bvw5dpz4myngtwu7@flea>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-13-quentin.schulz@free-electrons.com>
 <CACRpkdZYcSuhvn0b0qa0k1PQHoyXjNyjoyhR2sPme_t1pF12Dg@mail.gmail.com>
 <20171003144737.rhgtp3uwckhvoqdw@flea>
 <CAGb2v64=XL34x7iGJcEmmVnmzkA5wmyZJd-g827bY=kdHcZOMA@mail.gmail.com>
 <8be22e47-8071-be4c-0bd4-38fa51cbe3ff@free-electrons.com>
 <CAGb2v65-_MjUsfTHMoyzvczs_280p7NXEsStSaoR6wnvTCq5+A@mail.gmail.com>
 <20171011120036.bvw5dpz4myngtwu7@flea>
Message-ID: <CACRpkdY0GWqjkbxm=OBfRsTmkQ7kc86Dw96XUT08azSbD57Xrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 2:00 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> What about not enforcing any muxing state when we want to mux to the
> "ldo" function? We just leave it to whatever value it is, that way we
> keep it under the regulator framework's control, and we don't disrupt
> anything when the pin is requested.

In a way since setting the bits one way means "LDO on" and another
setting means "LDO off" those bits should be handled by the
regulator framework when used as a regulator, not pin control.

So I would say yes.

Yours,
Linus Walleij
