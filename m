From: lho@apm.com (Loc Ho)
Date: Tue, 22 Sep 2015 10:46:07 -0700
Subject: [PATCH v4 1/4] edac: Export edac_debugfs
In-Reply-To: <20150922163405.GC3437@pd.tnic>
References: <1439534769-22811-1-git-send-email-lho@apm.com>
 <1439534769-22811-2-git-send-email-lho@apm.com>
 <20150922163405.GC3437@pd.tnic>
Message-ID: <CAPw-ZTnMfvAtoXz_dHsLnwEm4N63Tdb+4c7NE+oLw28v+ozd7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> This patch exports and expose the edac_debugfs file node. This allows
>> EDAC driver to create debugfs node under the EDAC debugfs node.
>
> ...
>
>> -#ifdef CONFIG_EDAC_DEBUG
>> -static struct dentry *edac_debugfs;
>> +struct dentry *edac_debugfs;
>> +EXPORT_SYMBOL_GPL(edac_debugfs);
>
> Hmm, so Arnd was right about this being the wrong direction we're
> chasing. We should rather be exporting a bunch of EDAC debugfs wrappers
> which EDAC drivers can call instead of exposing edac_debugfs itself.
>
> And this is much better and the right(tm) approach IMO. So I went
> and hacked it in, it builds on those !x86 targets (as far as my
> cross-compilers are concerned, build succeeds :-)).
>
> So here it is as a follow-up to this message.

Let's me sync and give it a try. Do you see any other issue besides this?

-Loc
