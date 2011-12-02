From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 1 Dec 2011 23:38:57 -0500
Subject: [PATCH] arm: add default value for PHYS_OFFSET Kconfig setting
In-Reply-To: <201112011419.46751.arnd@arndb.de>
References: <1322711557-8279-1-git-send-email-paul.gortmaker@windriver.com>
 <201112011419.46751.arnd@arndb.de>
Message-ID: <CAP=VYLrp1zqyOzU-xzatF3jE3wL6wBjEDMR=sEXimP2ZvkQ0Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 1, 2011 at 9:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 01 December 2011, Paul Gortmaker wrote:
>> Commit 1b9f95f8ade9efc2bd49f0e7b9dc61a038ac3eef introduced the new
>> Kconfig for PHYS_OFFSET but it did not specify a default value.
>>
>> This has the undesired side effect of breaking an implictly used
>> trick for updating defconfigs on the fly for routine buildtesting
>> across all arch and all platforms, i.e.
>>
>> ? cp /path/to/somedefconfig .config ; yes "" | make oldconfig
>>
>
> FWIW, a better way to achieve the above is using
>
> make KCONFIG_ALLCONFIG=/path/to/somedefconfig listnewconfig alldefconfig
>
> which does not have this problem.
>
> Your patch looks still ok, but you might want to update your scripts
> to be more robust.

Thanks -- but on the other hand, the above use case does actually
emulate exactly what happens when someone runs the
"make oldconfig" and simply holds down the Enter key. (yes it
happens probably way more than we want to know...)

So, I guess what I'm trying to say is that the above "script" is
intentionally fragile.  :)  As a use case, we shouldn't break it.

Thanks,
Paul.

>
> ? ? ? ?Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
