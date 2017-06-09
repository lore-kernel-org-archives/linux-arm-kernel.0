From: nicolas.dichtel@6wind.com (Nicolas Dichtel)
Date: Fri, 9 Jun 2017 16:12:29 +0200
Subject: [PATCH] kbuild: replace genhdr-y with generated-y, deprecating
 genhdr-y
In-Reply-To: <1496996992-17857-1-git-send-email-yamada.masahiro@socionext.com>
References: <1496996992-17857-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <40a662b5-055b-b5ac-cebe-39b417b677de@6wind.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/06/2017 ? 10:29, Masahiro Yamada a ?crit :
> Prior to commit fcc8487d477a ("uapi: export all headers under uapi
> directories"), genhdr-y was meant to specify generated UAPI headers.
> 
> - generated-y: generated headers (other than asm-generic wrappers)
> - header-y   : headers to be exported
> - genhdr-y   : generated headers to be exported (generated-y + header-y)
> 
> Now headers under UAPI directories are all exported.  So, there is no
> more difference between generated-y and genhdr-y.
> 
> We see two users of genhdr-y, arch/{arm,x86}/include/uapi/asm/Kbuild.
> They generate some headers in arch/{arm,x86}/include/uapi/generated/
> directories, which are obviously exported.
> 
> Replace genhdr-y with generated-y, and deprecate genhdr-y.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Good catch. It eases the understanding of all those mechanisms.

After the fix of the typo in the commitlog:
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
