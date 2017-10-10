From: stephen@networkplumber.org (Stephen Hemminger)
Date: Tue, 10 Oct 2017 10:21:22 -0700
Subject: [PATCH v2] xdp: Sample xdp program implementing ip forward
In-Reply-To: <1507620532-25804-2-git-send-email-Christina.Jacob@cavium.com>
References: <1507620532-25804-1-git-send-email-Christina.Jacob@cavium.com>
 <1507620532-25804-2-git-send-email-Christina.Jacob@cavium.com>
Message-ID: <20171010102122.6ca1e756@shemminger-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Oct 2017 12:58:52 +0530
Christina Jacob <christina.jacob.koikara@gmail.com> wrote:

> +		bzero(&route, sizeof(route));
> +		bzero(dsts, sizeof(dsts));
> +		bzero(dsts_len, sizeof(dsts_len));
> +		bzero(gws, sizeof(gws));
> +		bzero(ifs, sizeof(ifs));
> +		bzero(&route, sizeof(route));

This is all unnecessary.
It looks like you write OpenBSD security code.
Only a security person would zero stack variables before return
and only BSD people use bzero(), Linux style is to use memset.
