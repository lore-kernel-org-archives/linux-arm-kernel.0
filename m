From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 22 Jun 2017 10:18:38 +0900
Subject: [PATCH] kbuild: replace genhdr-y with generated-y,
 deprecating genhdr-y
In-Reply-To: <1496996992-17857-1-git-send-email-yamada.masahiro@socionext.com>
References: <1496996992-17857-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAToMSMNFAKd-NHwvx=yAjFaho0qPk-6zU13WZbzfPbxqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-06-09 17:29 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
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

Applied to linux-kbuild/kbuild.



-- 
Best Regards
Masahiro Yamada
