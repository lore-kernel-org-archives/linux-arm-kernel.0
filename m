From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 12 Feb 2015 14:47:27 +0000
Subject: [PATCH] efi: get_memory_map: add sufficient slack for memory
 descriptors
In-Reply-To: <CAKv+Gu88vzPpXoSEs1ZSQbO7wsqh7NRSZc=iSpC9D6vzus7f8g@mail.gmail.com>
References: <1423718659-795-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150212102226.GB1245@leverpostej>
 <CAKv+Gu88vzPpXoSEs1ZSQbO7wsqh7NRSZc=iSpC9D6vzus7f8g@mail.gmail.com>
Message-ID: <20150212144727.GD4665@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Feb, at 06:39:46PM, Ard Biesheuvel wrote:
> 
> I don't see how doing a single allocation could result in a single
> free region to be split into more than 1 occupied region + 2 free
> regions.
> So no, I don't think it is ...

I don't think that's a guarantee we can make, nor is it something we
should rely upon.

Please explain the user-visible failure that this patch fixes. Does your
machine refuse to boot? Why is the 'goto again' loop insufficient in
handling this scenario?

-- 
Matt Fleming, Intel Open Source Technology Center
