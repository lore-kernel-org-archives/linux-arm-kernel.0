From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 10 Nov 2009 13:17:30 +0000
Subject: Runtime code modification fails on arm
In-Reply-To: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
References: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
Message-ID: <20091110131730.GA28509@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Papalagi Pakeha wrote:
> Does anyone have an idea what could be wrong here? Why does it work on
> x86 but fails to pick up the decrypted instructions on ARM? FWIW we
> use Samsung S3C2410 with kernel 2.6.27 and gcc 4.2.4 with glibc 2.3.3
> toolchain.

On ARM, you have to flush the cache whenever you modify code, or even
generate code in a new area.  There is a system call for this.

Only the cache covering the modified range needs to be flushed.  It
must clean the D-cache and flush the I-cache.

You have to do this on several other architectures too.  x86 is
unusual in not needing it.

-- Jamie
 
