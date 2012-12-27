From: lkundrak@v3.sk (Lubomir Rintel)
Date: Thu, 27 Dec 2012 20:56:03 +0100
Subject: [PATCH] dma: mv_xor: remove minimal offload length threshold
In-Reply-To: <1356636037-22948-1-git-send-email-lkundrak@v3.sk>
References: <1356636037-22948-1-git-send-email-lkundrak@v3.sk>
Message-ID: <1356638163.22102.0.camel@hobbes>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-12-27 at 20:20 +0100, Lubomir Rintel wrote:
> This fatally confuses dma_async_memcpy_buf_to_pg which thinks it signals an out
> of memory condition and retries indefinitelly, causing a soft lockup.

More of these here, it seems:
https://bugzilla.redhat.com/show_bug.cgi?id=845143
