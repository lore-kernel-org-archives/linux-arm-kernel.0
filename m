From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 14 May 2011 10:59:14 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate operation
	in thumb mode.
In-Reply-To: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
References: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
Message-ID: <BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2011 20:53, Vadim Bendebury <vbendeb@google.com> wrote:
> This is a cosmetic change, adding a '_thumb' prefix to the
> 'Hardware' line in /proc/cpuinfo. Tested as follows:
>
> localhost ~ # dmesg | grep thumb
> [ ? ?0.000000] Machine: kaen_thumb
> localhost ~ # grep '^Hardware' /proc/cpuinfo
> Hardware ? ? ? ?: kaen_thumb
> localhost ~ #

Would this break any script parsing this file?

BTW, why do you need it? You could include the .config into the kernel
and read it via /proc.

-- 
Catalin
