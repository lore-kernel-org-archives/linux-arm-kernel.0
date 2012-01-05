From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 5 Jan 2012 15:58:56 +0200
Subject: [PATCH 1/7] amp/remoteproc: add framework for controlling remote
 processors
In-Reply-To: <20120103233534.GC2492@ponder.secretlab.ca>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-2-git-send-email-ohad@wizery.com>
 <20120103233534.GC2492@ponder.secretlab.ca>
Message-ID: <CAK=WgbZTiS9czticnt4a1TKkR0SmsNKEvdHXfQpwC-N5DMjFXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 1:35 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> + ? ? /* go through the available ELF segments */
>> + ? ? for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
>> + ? ? ? ? ? ? u32 da = phdr->p_paddr;
>> + ? ? ? ? ? ? u32 memsz = phdr->p_memsz;
>> + ? ? ? ? ? ? u32 filesz = phdr->p_filesz;
>
> This could be an endianess problem. ?If the endianess of the host and
> the rproc are different, then what is the endianess of the elf file?
> Is the endianess of the elf file verified before attempting to parse it?
...
> Nitpick: A look up table would be easier to extend in the future.
>
> Otherwise;
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks, Grant!

If I may, I'll add something like this to the commit log:

Acked-by: Grant Likely <grant.likely@secretlab.ca> (minus two
Reported-by issues)

And then we could fix those two issues in two subsequent patches
(carrying your Reported-by) so reviewing the change would be much
easier, and we don't end up changing code (that has been lying in
linux-next) just before it is sent it to Linus.

Thanks a lot for your review!
Ohad.
