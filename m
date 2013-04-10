From: olof@lixom.net (Olof Johansson)
Date: Wed, 10 Apr 2013 10:48:38 -0700
Subject: [PATCH 1/2] ARM: boot/dts/Makefile: drop '\'
In-Reply-To: <5165A2E6.7010108@wwwdotorg.org>
References: <1365585444-11520-1-git-send-email-plagnioj@jcrosoft.com>
 <5165A2E6.7010108@wwwdotorg.org>
Message-ID: <CAOesGMhcT+0X9pFx7m2TVFFHAbnh443fqEgfY3zCvn9H04No5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:35 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/10/2013 03:17 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> when adding multiple new platform this generate comflict
>
> "When" and "conflict".
>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>
>> -ifeq ($(CONFIG_OF),y)
>
>> -targets += dtbs
>> -targets += $(dtb-y)
>> -endif
>> -
>> -# *.dtb used to be generated in the directory above. Clean out the
>> -# old build results so people don't accidentally use them.
>> -dtbs: $(addprefix $(obj)/, $(dtb-y))
>> -     $(Q)rm -f $(obj)/../*.dtb
>> -
>> -clean-files := *.dtb
>
> I'm not sure why those parts show up in the diff. I guess the -/+ lines
> look the same though, so the result is fine. did line-endings change or
> something?

There's no point in picking up this patch now if the move to
directories will happen in a release or two, it's again pure churn. We
can live with the conflicts for another release.


-Olof
