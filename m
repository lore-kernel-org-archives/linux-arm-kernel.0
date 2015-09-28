From: dianders@chromium.org (Doug Anderson)
Date: Mon, 28 Sep 2015 09:29:34 -0700
Subject: [PATCH v4] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <1442848061-4168-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1442848061-4168-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <CAD=FV=W6h6Nd=HQPYDcarCVNBmDQ6k4P2=Y_9rn6WM9Zc5ammw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir,

On Mon, Sep 21, 2015 at 8:07 AM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> - do I2C bus controller reinitialization on every data transfer,
>   this change hopefully solves some observed problems on RK3288 platform

My apologies, but this appears to be a bad idea...

We just discovered that this was the root cause of a bug.  If an HDCP
transfer is happening then the soft reset messes things up.  In our
tree we've moving things back to the way they were.  :(

-Doug
