From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Aug 2015 20:19:20 +0100
Subject: [PATCH 1/3] spi: bitbang: Replace spinlock by mutex when calling
 chipselect
In-Reply-To: <CANMq1KB2zxPPCbxh4K-REUgp-83s=MPcGRjz-p1fK1PQMzyLdw@mail.gmail.com>
References: <CANMq1KB2zxPPCbxh4K-REUgp-83s=MPcGRjz-p1fK1PQMzyLdw@mail.gmail.com>
Message-ID: <20150814191920.GK10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 06:24:05PM +0800, Nicolas Boichat wrote:

> Anyway, the "safer" way to fix this would be to keep the
> prepare/unprepare functions, busy variable, and just protect it with a
> mutex instead of a spinlock...

OK, that seems reasonable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/a3aba122/attachment.sig>
