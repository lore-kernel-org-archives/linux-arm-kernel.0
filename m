From: keescook@chromium.org (Kees Cook)
Date: Thu, 28 Jan 2016 06:06:53 -0800
Subject: [PATCH] arm64: make CONFIG_DEBUG_RODATA non-optional
In-Reply-To: <20160128110622.GF17123@leverpostej>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
 <1453226922-16831-4-git-send-email-keescook@chromium.org>
 <20160127211105.GA41450@davidb.org>
 <CAGXu5j+DLRoVE88a9++jVfEkN90HDiAaDAMnT2TrKqtMZ_yOww@mail.gmail.com>
 <20160128000906.GA42530@davidb.org>
 <20160128110622.GF17123@leverpostej>
Message-ID: <CAGXu5jLy3cpLzU1MSQhS6q=5rMu2Mdp9pXncoFapPqUyQ1fO0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 3:06 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> One thing I would like to do is to avoid the need for fixup_executable
> entirely, by mapping the kernel text RO from the outset. However, that
> requires rework of the alternatives patching (to use a temporary RW
> alias), and I haven't had the time to look into that yet.

This makes perfect sense for the rodata section, but the (future)
postinit_rodata section we'll still want to mark RO after init
finishes. x86 and ARM cheat by marking both RO after init, and they
don't have to pad sections. parisc will need to solve this too.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
