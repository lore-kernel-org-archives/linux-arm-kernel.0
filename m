From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 31 Aug 2013 00:14:22 +0100
Subject: [PATCH 12/16] Fix types in EFI calls to match EFI function
 definitions.
In-Reply-To: <CAFECyb-J4gTiAQkKVT8qt94Tk6-_jVdX=sNM7VkXkyvPdEeZFA@mail.gmail.com>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-13-git-send-email-roy.franz@linaro.org>
 <20130830133902.AEA7A3E102A@localhost>
 <CAFECyb-J4gTiAQkKVT8qt94Tk6-_jVdX=sNM7VkXkyvPdEeZFA@mail.gmail.com>
Message-ID: <CACxGe6tJyGDN5nTePuwcV_W44Fk+mku+V8EoOvPaos72mbKdEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 12:12 AM, Roy Franz <roy.franz@linaro.org> wrote:
> On Fri, Aug 30, 2013 at 6:39 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> I think you need some description in the commit text about why the type
>> of chunksize is changing. It's not clear why you're making this change.
>> It is a bug fix?
>
> The type was changed to match the EFI_FILE_PROTOCOL specification -
> chunk size is
> defined as a native width unsigned integer.  So yes, this is a bug in
> that this is wrong for
> ia32, since that really should be a u32 in that case.
> Since the x86 wrappers break type checking by the compiler these types
> were never checked at compile time
> before.  chunksize is the the only change that isn't a cast to a type
> of void pointer.
>
> I can break this change out as a separate patch if desired.

I don't think it needs to be in a separate patch, but it does need to
be described in the patch description.

g.
