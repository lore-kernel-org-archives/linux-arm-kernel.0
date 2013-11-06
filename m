From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Nov 2013 07:40:43 -0800
Subject: [PATCH] arm,arm64: Conditionalize bio_vec usage
In-Reply-To: <1383743117-4138-1-git-send-email-treding@nvidia.com>
References: <1383743117-4138-1-git-send-email-treding@nvidia.com>
Message-ID: <CAOesGMjCeTeoF3M4UNY4zzAMyBFLddcwaXU91ur28hGca2uBHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 5:05 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> Commit 3d1975b57097 (arm,arm64: do not always merge bio_vec if we are
> running on Xen) unconditionally added code using the bio_vec typedefs
> which causes build errors on configurations where CONFIG_BLOCK is
> disabled.
>
> Add #ifdef CONFIG_BLOCK protection to fix this.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

I commented on the offending patch (which is a good way to make people
aware of it instead of posting standalone patches like you did), and
Stefano posted patch that declares struct bio_vec; instead.

Either way is ok with me, I'd generally prefer to avoid the ifdefs though.


-Olof
