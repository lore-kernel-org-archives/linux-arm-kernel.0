From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 11 Mar 2015 16:52:49 +0200
Subject: [PATCH] nfs: do not export discarded symbols
In-Reply-To: <3173686.FPJdK9jLbA@wuerfel>
References: <3173686.FPJdK9jLbA@wuerfel>
Message-ID: <20150311145249.GH2177@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Mar 11, 2015 at 02:37:25PM +0100, Arnd Bergmann wrote:
> The function nfs4_pnfs_v3_ds_connect_unload is exported so it can be
> used by other modules, but is also marked '__exit' and will be
> discarded when built into the kernel, as pointed out by this
> linker error:
> 
> `nfs4_pnfs_v3_ds_connect_unload' referenced in section `___ksymtab_gpl+nfs4_pnfs_v3_ds_connect_unload' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o
> 
> This removes the __exit annotation to make it safe to call this function.

Should be "do not discard exported symbols" in subject then?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
