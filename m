From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 9 May 2014 09:51:59 -0700
Subject: [PATCH] i2c: qup: Fix pm_runtime_get_sync usage
In-Reply-To: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
References: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
Message-ID: <CAJAp7OgN8rmnC9zsmt7FFcWUauebbfCg30_FC9BhgS3GkeZEFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 2, 2014 at 6:54 PM, Andy Gross <agross@codeaurora.org> wrote:
[...]
> @@ -479,7 +479,7 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
>         int ret, idx;
>
>         ret = pm_runtime_get_sync(qup->dev);
> -       if (ret)
> +       if (ret < 0)
>                 goto out;

Sorry about that, thought I tested that path properly.
Wolfram, please pick this up as soon as possible as it renders the
driver useless if one enables pm runtime.

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
