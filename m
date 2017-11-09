From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 9 Nov 2017 10:54:57 -0800
Subject: [PATCH 10/15] arm64: disable ARM64_ERRATUM_843419 for clang LTO
In-Reply-To: <CAKv+Gu8JmZ_V2aq6+TGgjyJ_ndjj8znu97E0iri+aa-FXxr9uA@mail.gmail.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-12-samitolvanen@google.com>
 <CAKv+Gu8JmZ_V2aq6+TGgjyJ_ndjj8znu97E0iri+aa-FXxr9uA@mail.gmail.com>
Message-ID: <20171109185457.GA137560@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 08:13:20PM +0000, Ard Biesheuvel wrote:
> I wonder it makes sense to disable such relocations entirely when we
> enable this erratum. If the toolchain does not generate them, they
> shouldn't occur in the first place, and having this dependency here
> seems awkward as well.

I agree. Unless someone objects, I'll replace this in v2 with a patch that
leaves the relocations in module.c even when the erratum is selected.

Sami
