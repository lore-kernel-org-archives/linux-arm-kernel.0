From: olof@lixom.net (Olof Johansson)
Date: Thu, 12 Sep 2013 17:57:32 -0700
Subject: [PATCH] memory: add a basic OF-based memory driver
In-Reply-To: <1379032225-6425-1-git-send-email-emilio@elopez.com.ar>
References: <1378863781-4235-1-git-send-email-emilio@elopez.com.ar>
 <1379032225-6425-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAOesGMiUMniKRLRgGPsimR0bXWQFbx+SL5dUJXOb8t0JfEcHsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 5:30 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> This driver's only job is to claim and ensure the necessary clock
> for memory operation on a DT-powered machine remains enabled.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>
> I believe this new patch should resolve all the concerns raised; as
> always, all feedback is welcome :)

I think you're going about this the wrong way.

If you have a problem with a clock not staying on, shouldn't you just
marking it appropriately in the clock table instead, making sure it's
initialized with at least one reference to it? I believe that is how
some of the other platforms handle this, and it's a lot cleaner than
adding a fake binding and a fake driver just to grab a single clock.


-Olof
