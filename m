From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 12 Apr 2016 20:57:27 +0100
Subject: [PATCH v2 4/5] efi: implement generic support for the Memory
 Attributes table
In-Reply-To: <CAKv+Gu-TMb0MTnzXXjczvxaWvZphu7M1-MMdjCrZ7A2CvCc2WQ@mail.gmail.com>
References: <1459355933-13529-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459355933-13529-5-git-send-email-ard.biesheuvel@linaro.org>
 <20160408155608.GQ2701@codeblueprint.co.uk>
 <CAKv+Gu-TMb0MTnzXXjczvxaWvZphu7M1-MMdjCrZ7A2CvCc2WQ@mail.gmail.com>
Message-ID: <20160412195727.GG2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Apr, at 04:09:11PM, Ard Biesheuvel wrote:
> 
> The spec does not actually mandate that, and I do know that the
> Tianocore code deliberately uses a larger value for desc_size in
> GetMemoryMap() to catch inadvertent uses of sizeof(). I am not sure if
> the memory attribute table code does the same, and it seems dangerous
> to assume that to be the case in general.
 
The spec may not mandate that, but this code will explode horribly if
efi_memory_desc_t does not accurately describe the entries in either
the EFI Memory Attributes table or the EFI memory map.

How do we ensure that doing,

static bool entry_is_valid(...)
{
	*out = *in;
	...

keeps working? Are we using the table version to guarantee that?
