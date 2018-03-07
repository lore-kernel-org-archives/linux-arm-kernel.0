From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 7 Mar 2018 09:51:58 +0100
Subject: [PATCH] ARM: dts: BCM5301X: add missing LEDs for Buffalo
 WZR-900DHP
In-Reply-To: <1520260563-4167-1-git-send-email-musashino.open@gmail.com>
References: <1520260563-4167-1-git-send-email-musashino.open@gmail.com>
Message-ID: <CACna6rwKt1wdryaSs1DsGztSjugBbfRfQqpzGKjvqWf=j=N5kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2018 at 15:36,  <musashino.open@gmail.com> wrote:
> From: INAGAKI Hiroshi <musashino.open@gmail.com>
>
> Buffalo WZR-900DHP has 8 LEDs, but there is not LED definitions in the
> dts and cannot configure these LEDs.
> I Added missing LED definitions for WZR-900DHP.
>
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>

Looks almost good, thanks for sending this patch to Florian.

One comment: please drop all linux,default-trigger = "default-off";
lines. I did the same mistake long time ago, see my fixing commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b660259e927177dc0c6eb3b1c39f23c6a011c5f

When you fix that, please generate a V2 of your patch, you can do it
with something like:
git format-patch --subject-prefix="PATCH V2" -1
and send again the same way.

Thanks!
