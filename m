From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 27 Apr 2017 17:54:44 +0200
Subject: [RFC kvm-unit-tests PATCH 4/8] Makefiles: use explicit path for
 including sub-Makefiles
In-Reply-To: <20170407122010.umftrqr2qqd6g3q4@kamzik.brq.redhat.com>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-5-alex.bennee@linaro.org>
 <20170407122010.umftrqr2qqd6g3q4@kamzik.brq.redhat.com>
Message-ID: <328f9a03-d6ec-2d3a-af41-e107b4651fea@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/04/2017 14:20, Andrew Jones wrote:
>> -LIBFDT_objdir = lib/libfdt
>> -LIBFDT_srcdir = lib/libfdt
>> +LIBFDT_objdir = $(SRCDIR)/lib/libfdt
>> +LIBFDT_srcdir = $(SRCDIR)/lib/libfdt
>>  LIBFDT_archive = $(LIBFDT_objdir)/libfdt.a
>>  LIBFDT_include = $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_INCLUDES))
>>  LIBFDT_version = $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_VERSION))
> Can't we just do VPATH += $LIBFDT_srcdir instead?

That would search for every file in the lib/libfdt subdirectory of the
source directory, while here the desired prefix is just $(SRCDIR).

Paolo
