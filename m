From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 17 Aug 2013 08:30:14 +0400
Subject: [PATCH RESEND] can: mcp251x: Replace power callbacks with
 regulator API
In-Reply-To: <520EDDA8.6050309@gmail.com>
References: <1375963227-6468-1-git-send-email-shc_work@mail.ru>
 <52049C44.6030902@pengutronix.de> <520EDDA8.6050309@gmail.com>
Message-ID: <20130817083014.a01144051b158c34ec7dd9d9@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17 Aug 2013 10:19:20 +0800
Haojian Zhuang <haojian.zhuang@gmail.com> wrote:

> On 08/09/2013 03:37 PM, Marc Kleine-Budde wrote:
> > On 08/08/2013 02:00 PM, Alexander Shiyan wrote:
> >> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> >> ---
> >>   arch/arm/mach-pxa/icontrol.c         |  3 --
> >>   arch/arm/mach-pxa/zeus.c             | 46 ++++++++++----------
> >
> > What's pxa's status of DT conversion? Do you (still) accept patches to
> > board files?
> >
> > Marc
> >
> 
> Since DT conversion isn't finished, I still accept the board files.
> But this patch should be split into two parts. One is for pxa, and the
> other one is for net.

Patch cannot be splitted because this can create hole which break git-bisect.

In any case, I want to create a v2 with a more detailed description, and I
have a supplementary question for the CAN subsystem maintainers.
"Transciever power" is not used by any of the boards, can we remove it
completely? This will greatly simplify driver.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
