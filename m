From: ccross@android.com (Colin Cross)
Date: Tue, 20 Jul 2010 00:14:08 -0700
Subject: [PATCH 1/8] arm/mach-tegra: fix unsigned calcs
In-Reply-To: <1279219395-12088-1-git-send-email-segooon@gmail.com>
References: <1279219395-12088-1-git-send-email-segooon@gmail.com>
Message-ID: <AANLkTinFKH4Ed3UW3kMKdT5RJwmmE5n5k7nO01mB9xpO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 11:43 AM, Kulikov Vasiliy <segooon@gmail.com> wrote:
> divider_u71 is unsigned, so this check is buggy:
> if (divider_u71 - 2 > 255 || divider_u71 - 2 < 0)
>
> If divider_u71 is 0 or 1 both checks are lying.
> So, it does not produce a buggy answer, but it is confusing.

Hi Kulikov,
Thanks for the patch.  This problem has been fixed in another patch in
the linux-tegra tree, I'll post it for review and update the
linux-next tree soon.

Colin Cross
