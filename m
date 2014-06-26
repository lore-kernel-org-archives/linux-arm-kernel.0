From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 Jun 2014 09:53:34 +0200
Subject: [PATCH 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <20140625134235.4f32768faa1a4380a62458ff@linux-foundation.org>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
 <20140625134235.4f32768faa1a4380a62458ff@linux-foundation.org>
Message-ID: <20140626075334.GA12054@laptop.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 01:42:35PM -0700, Andrew Morton wrote:
> On Wed, 25 Jun 2014 16:40:18 +0100 Steve Capper <steve.capper@linaro.org> wrote:
> 
> > This series implements general forms of get_user_pages_fast and
> > __get_user_pages_fast and activates them for arm and arm64.
> 
> Why not x86?
> 
> I think I might have already asked this.  If so, it's your fault for
> not updating the changelog ;)

Because x86 doesn't do RCU freed page tables :-) Also because i386 PAE
has magic (although one might expect ARM PAE -- or whatever they called
it -- to need similar magic).
