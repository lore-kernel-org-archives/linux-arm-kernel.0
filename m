From: bp@alien8.de (Borislav Petkov)
Date: Tue, 22 Sep 2015 18:34:05 +0200
Subject: [PATCH v4 1/4] edac: Export edac_debugfs
In-Reply-To: <1439534769-22811-2-git-send-email-lho@apm.com>
References: <1439534769-22811-1-git-send-email-lho@apm.com>
 <1439534769-22811-2-git-send-email-lho@apm.com>
Message-ID: <20150922163405.GC3437@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 12:46:06AM -0600, Loc Ho wrote:
> This patch exports and expose the edac_debugfs file node. This allows
> EDAC driver to create debugfs node under the EDAC debugfs node.

...

> -#ifdef CONFIG_EDAC_DEBUG
> -static struct dentry *edac_debugfs;
> +struct dentry *edac_debugfs;
> +EXPORT_SYMBOL_GPL(edac_debugfs);

Hmm, so Arnd was right about this being the wrong direction we're
chasing. We should rather be exporting a bunch of EDAC debugfs wrappers
which EDAC drivers can call instead of exposing edac_debugfs itself.

And this is much better and the right(tm) approach IMO. So I went
and hacked it in, it builds on those !x86 targets (as far as my
cross-compilers are concerned, build succeeds :-)).

So here it is as a follow-up to this message.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
