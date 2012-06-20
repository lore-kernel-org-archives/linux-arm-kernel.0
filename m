From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 10:25:30 +0200
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <CAOh2x=kOU=X2V5zBg4G_SWzNSfQyoeygwgW-vO-xxRkDXzZDJQ@mail.gmail.com>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
 <201205122142.02318.arnd@arndb.de>
 <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
 <4FB47DE2.4070704@st.com>
 <CACRpkdYGuqg3xy+x+adREEzkPL9RFzDDBaEBttR-HarZ7jWuFA@mail.gmail.com>
 <CAOh2x=kOU=X2V5zBg4G_SWzNSfQyoeygwgW-vO-xxRkDXzZDJQ@mail.gmail.com>
Message-ID: <CACRpkday9+zhMHWWjNNBfhhQ2NXPc+RoGkHvxodud5HY7hLm4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 4:11 PM, viresh kumar <viresh.linux@gmail.com> wrote:

> @Grant: Can we have your comments here please. Or any other better
> solution to the problem
> we are facing. I do hope, my last suggestion is not that bad.

I did hunt Grant down in Hong Kong (this make me sound like some
secret agent...) and we discussed this with Dong Aisheng.

The outcome was basically this work item from Linaro:
https://blueprints.launchpad.net/linux-linaro/+spec/pinctrl-gpiorange-makeover

So the idea is that GPIO drivers should register their pin ranges
instead of the other way around (pinctrl drivers register them, as it
is done today), and that we need to move the mapping to be
GPIO-driver local, which in turn mandates stashing the
struct gpio_chip into the GPIO range mapping.

Not a simple refactoring but probably necessary (all current users need
to be switched over).

Interested? ;-)

Yours,
Linus Walleij
