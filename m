From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 1 Dec 2016 14:36:05 +0300
Subject: [PATCHv4 08/10] mm/kasan: Switch to using __pa_symbol and lm_alias
In-Reply-To: <1480445729-27130-9-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-9-git-send-email-labbott@redhat.com>
Message-ID: <2f3ac043-c4cc-5c5a-8ac7-1396b6bb193f@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016 09:55 PM, Laura Abbott wrote:
> __pa_symbol is the correct API to find the physical address of symbols.
> Switch to it to allow for debugging APIs to work correctly.

But __pa() is correct for symbols. I see how __pa_symbol() might be a little
faster than __pa(), but there is nothing wrong in using __pa() on symbols.

> Other
> functions such as p*d_populate may call __pa internally. Ensure that the
> address passed is in the linear region by calling lm_alias.

Why it should be linear mapping address? __pa() translates kernel image address just fine.
This lm_alias() only obfuscates source code. Generated code is probably worse too.
