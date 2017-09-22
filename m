From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Sep 2017 09:10:41 +0100
Subject: [PATCH 0/4] iirqchip: Handle return value of kasprintf
In-Reply-To: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
 (Arvind Yadav's message of "Wed, 20 Sep 2017 13:38:18 +0530")
References: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <86vakbnofy.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20 2017 at  1:38:18 pm BST, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> kasprintf() can fail here and we must check its return value.

Or not. The use of these strings is purely cosmetic (they are only used
to display various debug information), and printk is perfectly able to
handle a NULL string.

Refusing to probe an essential piece of HW because a debug feature
failed seems at best counter-productive.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
