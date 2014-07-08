From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 8 Jul 2014 10:52:47 +0100
Subject: [PATCH 2/2] efi: implement mandatory locking for UEFI Runtime
 Services
In-Reply-To: <CAKv+Gu9HkJgsnzUAROVwPKaHGHRU9FwAp+eOT8N8kYDR3Dda+w@mail.gmail.com>
References: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
 <1404295802-28030-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140707202954.GC27474@console-pimps.org>
 <CAKv+Gu91CQADTQ8KMjXQPwVDvW1XkUYO2E5=Mu=aAtrB8B3q_A@mail.gmail.com>
 <CAKv+Gu8LbfuuEYyhAeu3dUiKHqzN_UFMbOjY0agVihbmmVL9CA@mail.gmail.com>
 <20140708092958.GD27474@console-pimps.org>
 <CAKv+Gu9HkJgsnzUAROVwPKaHGHRU9FwAp+eOT8N8kYDR3Dda+w@mail.gmail.com>
Message-ID: <20140708095247.GE27474@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Jul, at 11:45:03AM, Ard Biesheuvel wrote:
> 
> Well, that is what is says in the comment:
>          * ops.get_next_variable() is only called from register_efivars()
>          * or efivar_update_sysfs_entries(),
>          * which is protected by the BKL, so that path is safe.
 
Oops, so it does. That's a stale comment. I'll update it.

> I agree. So shall I update my patch to add a single spin_lock that is
> used by all wrappers?
> We will likely need the wrappers on ARM as well, only ia64 needs
> another approach (if desired)

Please do, that would be great!

-- 
Matt Fleming, Intel Open Source Technology Center
